Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263470AbTCNSc5>; Fri, 14 Mar 2003 13:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263471AbTCNSc4>; Fri, 14 Mar 2003 13:32:56 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:51725 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263470AbTCNScz>;
	Fri, 14 Mar 2003 13:32:55 -0500
Date: Fri, 14 Mar 2003 10:32:27 -0800
From: Greg KH <greg@kroah.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, david-b@pacbell.net,
       wahrenbruch@kobil.de, torvalds@transmeta.com
Subject: Re: Memleak in KOBIL USB Smart Card Terminal Driver
Message-ID: <20030314183227.GE6649@kroah.com>
References: <20030312200050.GA28090@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312200050.GA28090@linuxhacker.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 11:00:50PM +0300, Oleg Drokin wrote:
> Hello!
> 
>    There is a memleak on error exit path in KOBIL USB Smart Card Terminal
>    Driver in both current 2.4 and 2.5.
>    See the patch.
>    Found with help of smatch + enhanced unfree script.

Applied to both my 2.4 and 2.5 trees, thanks.

greg k-h
