Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262079AbTCRBfl>; Mon, 17 Mar 2003 20:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbTCRBfl>; Mon, 17 Mar 2003 20:35:41 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:18959 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S262079AbTCRBfk>;
	Mon, 17 Mar 2003 20:35:40 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Mon, 17 Mar 2003 17:46:29 -0800
To: Javier Achirica <achirica@telefonica.net>
Cc: Thomas Hood <jdthood0@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Cisco Aironet 340 oops with 2.4.20
Message-ID: <20030317174629.A29068@jose.vato.org>
Mail-Followup-To: Tim Pepper <tpepper>,
	Javier Achirica <achirica@telefonica.net>,
	Thomas Hood <jdthood0@yahoo.co.uk>, linux-kernel@vger.kernel.org
References: <20030316163358.A25887@jose.vato.org> <Pine.SOL.4.30.0303170227020.6371-100000@tudela.mad.ttd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SOL.4.30.0303170227020.6371-100000@tudela.mad.ttd.net>; from achirica@telefonica.net on Mon, Mar 17, 2003 at 02:28:58AM +0100
X-PGP-Key: http://vato.org/~tpepper/pubkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems like the following does it:

- run for a while
- suspend
- wake..run for a while
- maybe suspend and wake a few more times?
- cause a heavish burst of net traffic

If it would matter I'm running wep.  It may happen more often when I've
got an ipsec tunnel running over the connection as well (tunnel never
left open during suspend nor ipsec module left loaded).  When it's
happened cpu utilisation was pretty low.

t.
-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
