Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284732AbSBRUtB>; Mon, 18 Feb 2002 15:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285229AbSBRUsw>; Mon, 18 Feb 2002 15:48:52 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:44806 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284732AbSBRUsi>;
	Mon, 18 Feb 2002 15:48:38 -0500
Date: Mon, 18 Feb 2002 12:43:45 -0800
From: Greg KH <greg@kroah.com>
To: Patrik Weiskircher <me@justp.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: khubd zombie
Message-ID: <20020218204345.GF20284@kroah.com>
In-Reply-To: <1014039193.523.42.camel@dev1lap> <20020218181417.GA19992@kroah.com> <1014062182.608.36.camel@pat> <20020218200041.GE20284@kroah.com> <1014063390.6649.8.camel@pat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1014063390.6649.8.camel@pat>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 21 Jan 2002 17:13:00 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 09:16:30PM +0100, Patrik Weiskircher wrote:
> 
> khubd is a kernel thread, yes.
> But if I issue a 'killall khubd' it shouldn't become a zombie.

Agreed.  I'll look into this.

> > And what happened to your USB devices when you kill khubd after applying
> > your patch?
> 
> They work as always.

Try removing a device, or plugging a new one in :)

greg k-h
