Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135401AbRDWPsX>; Mon, 23 Apr 2001 11:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135443AbRDWPsO>; Mon, 23 Apr 2001 11:48:14 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:57861 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S135401AbRDWPr6>; Mon, 23 Apr 2001 11:47:58 -0400
Date: Mon, 23 Apr 2001 16:48:40 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pedantic code cleanup - am I wasting my time with this?
Message-ID: <20010423164840.A29013@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Jesper Juhl <juhl@eisenstein.dk>, linux-kernel@vger.kernel.org
In-Reply-To: <3AE449A3.3050601@eisenstein.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AE449A3.3050601@eisenstein.dk>; from juhl@eisenstein.dk on Mon, Apr 23, 2001 at 05:26:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 05:26:27PM +0200, Jesper Juhl wrote:
> All the above does is to remove the last comma from 3 enumeration lists. 
> I know that gcc has no problem with that, but to be strictly correct the 
> last entry should not have a trailing comma.
> 

Sadly not.  This isn't a gcc thing: ANSI says that trailing comma is ok (K&R
Second edition, A8.7 - pg 218 &219 in my copy)

Sean
