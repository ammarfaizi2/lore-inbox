Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265646AbTFNMp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 08:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265656AbTFNMp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 08:45:57 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65467
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265646AbTFNMp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 08:45:56 -0400
Subject: Re: 2.4.21: cmedia PCM not working
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ton Hospel <linux-kernel@ton.iguana.be>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <bcf487$4l8$1@post.home.lunix>
References: <bcf487$4l8$1@post.home.lunix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055595446.8281.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2003 13:57:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-14 at 13:25, Ton Hospel wrote:
> So I suspect that while indeed you don't want a pcm volume level for
> a CMI65, just adding that line also gets rid of some needed 
> initialization.

Correct - should be fixed in -ac. You need to turn off the mute in the
init code.

