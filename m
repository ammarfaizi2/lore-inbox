Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbTCQQQD>; Mon, 17 Mar 2003 11:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261760AbTCQQQD>; Mon, 17 Mar 2003 11:16:03 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:63641 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261756AbTCQQQC>; Mon, 17 Mar 2003 11:16:02 -0500
Date: Mon, 17 Mar 2003 16:24:21 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Philippe De Muyter <phdm@macqel.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sundance DFE-580TX DL10050B patch
Message-ID: <20030317172416.GA3366@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Philippe De Muyter <phdm@macqel.be>, linux-kernel@vger.kernel.org
References: <200303171356.h2HDu9U30575@mail.macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303171356.h2HDu9U30575@mail.macqel.be>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 02:56:09PM +0100, Philippe De Muyter wrote:

 > +		writew((dev->dev_addr[i + 1] << 8) + dev->dev_addr[i],

Don't you want to OR those together instead of add them ?

		Dave

