Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264409AbUFDDJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUFDDJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 23:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUFDDJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 23:09:55 -0400
Received: from pka.khmer.cc ([216.40.225.66]:55472 "EHLO pka.khmer.cc")
	by vger.kernel.org with ESMTP id S264409AbUFDDJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 23:09:54 -0400
X-ClientAddr: 66.91.235.228
Message-ID: <40BFE7FE.4070108@khmer.cc>
Date: Thu, 03 Jun 2004 20:09:50 -0700
From: Vibol Hou <vibol@khmer.cc>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Aaron Mulder <ammulder@alumni.princeton.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dell TrueMobile 1150 PCMCIA/Orinoco/Yenta problem w/ 2.6.4/5
References: <Pine.LNX.4.58.0406022305580.6314@saturn.opentools.org>
In-Reply-To: <Pine.LNX.4.58.0406022305580.6314@saturn.opentools.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-KhmerConnection-MailScanner-Information: Please contact the ISP for more information
X-KhmerConnection-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I guess I'm assuming that this is a kernel bug and that it
> shouldn't matter if the orinoco_cs module is loaded before PCMCIA and/or
> yenta_socket.  But I guess it could be a distro bug if the module behavior
> is intentional.

AFAICS, this behavior is intentional.  The orinoco_cs driver depends on the pcmcia subsystem to 
communicate properly with your wireless card.

-Vibol
