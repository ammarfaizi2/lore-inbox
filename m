Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264552AbTDYAAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 20:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbTDXX72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:59:28 -0400
Received: from A17-250-248-89.apple.com ([17.250.248.89]:23249 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id S264549AbTDXX6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:58:55 -0400
Date: Fri, 25 Apr 2003 10:11:33 +1000
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
From: Stewart Smith <stewartsmith@mac.com>
In-Reply-To: <87lly6flrz.fsf@deneb.enyo.de>
Message-Id: <791E70DC-76B2-11D7-BE62-00039346F142@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, April 20, 2003, at 03:18  AM, Florian Weimer wrote:
> IDE disks automatically remap defective sectors, so you won't see any
> of them unless the disk is already quite broken.

IIRC:
A drive that has trouble reading a sector will remap it. If the sector 
is dead and it can't read it at all, you're screwed and you don't get 
your data. This is why you still see 'unreadable sector' error messages 
from your drive.
------------------------------
Stewart Smith
stewartsmith@mac.com
Ph: +61 4 3884 4332
ICQ: 6734154

