Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVBUG4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVBUG4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 01:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVBUG4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 01:56:51 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:11682 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261902AbVBUG4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 01:56:50 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Miles Bader <miles@gnu.org>
Subject: Re: [BK] upgrade will be needed
Date: Mon, 21 Feb 2005 01:56:46 -0500
User-Agent: KMail/1.7.2
Cc: "Theodore Ts'o" <tytso@mit.edu>, Sean <seanlkml@sympatico.ca>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Chris Friesen <cfriesen@nortel.com>, "d.c" <aradorlinux@yahoo.es>,
       cs@tequila.co.jp, galibert@pobox.com, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
References: <seanlkml@sympatico.ca> <20050218162729.GA5839@thunk.org> <buomzty5uyw.fsf@mctpc71.ucom.lsi.nec.co.jp>
In-Reply-To: <buomzty5uyw.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502210156.47993.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 February 2005 00:43, Miles Bader wrote:
> "Theodore Ts'o" <tytso@mit.edu> writes:
> > The "cost" of using BK seems to be primarily more theoretical, and
> > ideological, than real.
> 
> I've never used BK (not allowed to), but some things I've read about it
> sound quite annoying.  For instance:
> 
>  * Every source tree contains your entire repository => massive disk usage

It's not too bad as you just hardlink most of the trees to their parent.
 
>  * Must "unlock" files before working on them ("bk edit"); I recall
>    doing this with RCS, and it was, well, a real pain.

I think there is a setting to have them checked out for editing automatically.

-- 
Dmitry
