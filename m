Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTCEQiN>; Wed, 5 Mar 2003 11:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTCEQiM>; Wed, 5 Mar 2003 11:38:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57098 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266091AbTCEQiM>; Wed, 5 Mar 2003 11:38:12 -0500
Message-ID: <3E662A5C.4060307@zytor.com>
Date: Wed, 05 Mar 2003 08:48:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: DervishD <raul@pleyades.net>, linux-kernel@vger.kernel.org
Subject: Re: Unable to boot a raw kernel image :??
References: <200303051633.h25GXkYk005773@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200303051633.h25GXkYk005773@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> 
> Doesn't the in kernel bootloader have uses other than booting from
> floppy?  What if you want to boot from a custom network boot prom?
> 

Then you probably need Etherboot.  The in-kernel boot loader
(bootsect.S) will not help you.

	-hpa


