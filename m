Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVCSUTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVCSUTX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 15:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVCSUTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 15:19:23 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:40614 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261287AbVCSUTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 15:19:20 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend-to-disk woes
Date: Sat, 19 Mar 2005 12:20:35 -0800
User-Agent: KMail/1.7
Cc: erik.andren@gmail.com, linux-kernel@vger.kernel.org
References: <423B01A3.8090501@gmail.com> <20050319132612.GA1504@openzaurus.ucw.cz>
In-Reply-To: <20050319132612.GA1504@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503191220.35207.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 March 2005 05:26, Pavel Machek wrote:

> Checking that would be hard, but you might want to provide patch to check
> last-mounted dates of filesystems and panic if they changed.
> 				Pavel

Then how would you fix it?  There'd also have to be a way to reset it, 
otherwise the kernel will never boot again.  Perhaps an argument to the 
kernel that allows for resetting of the mechanism?

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Agoura, CA
