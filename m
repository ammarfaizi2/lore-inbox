Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTCCPQn>; Mon, 3 Mar 2003 10:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265675AbTCCPQn>; Mon, 3 Mar 2003 10:16:43 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32478 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265637AbTCCPQm>; Mon, 3 Mar 2003 10:16:42 -0500
Date: Mon, 3 Mar 2003 15:27:06 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Stephen Cameron <steve.cameron@hp.com>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [PATCH] cciss: add passthrough ioctl
Message-ID: <20030303152706.C30584@devserv.devel.redhat.com>
References: <20030303032640.GA13102@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030303032640.GA13102@zuul.cca.cpqcorp.net>; from steve.cameron@hp.com on Mon, Mar 03, 2003 at 09:26:40AM +0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 09:26:40AM +0600, Stephen Cameron wrote:
> Because, in order to flash the array controller firmware,
> it's got to be done that way...

I don't buy this. Sorry. What's against creating a device for this
controller itself ? 
(And yes, the kernel could use a formal ioctl number for "upgrade firmware") 
