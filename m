Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264138AbUE1WMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUE1WMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUE1WJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:09:36 -0400
Received: from mail.aei.ca ([206.123.6.14]:22773 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262361AbUE1VlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:41:17 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.7-rc1-mm1] cant mount reiserfs using -o barrier=flush
Date: Fri, 28 May 2004 17:39:53 -0400
User-Agent: KMail/1.6.2
Cc: Jens Axboe <axboe@suse.de>, Gunther Persoons <gunther_persoons@spymac.com>
References: <1085689455.7831.8.camel@localhost> <40B72886.3000507@spymac.com> <20040528121822.GH20657@suse.de>
In-Reply-To: <20040528121822.GH20657@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405281739.53892.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 28, 2004 08:18 am, Jens Axboe wrote:
> error=0x04 is an aborted command, meaning it's not supported. So
> ide-disk dumps that message to the log (barrier support doesn't work)
> and turns it off. This is expected behaviour if your drive doesn't
> support cache flushing.

Then I would expect to see the message _once_.   In my case I have 8
entries with these errors in my logs (then I rebooted).  Once would not 
be bad but 8 indicates to me that something is not respecting the flag
(or its being reset).

Ed
