Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTIXIrv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 04:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTIXIrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 04:47:51 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:59142 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261334AbTIXIru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 04:47:50 -0400
Date: Wed, 24 Sep 2003 10:46:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: ATTACK TO MY SYSTEM
Message-ID: <20030924084616.GA16727@alpha.home.local>
References: <200309240740.h8O7eZNI000474@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309240740.h8O7eZNI000474@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 24, 2003 at 08:40:35AM +0100, John Bradford wrote:
 
> RFC 822, section 3.4.7, makes clear that case is _not_ significant for
> these field names.  RFC 2822 doesn't change this.

Sorry John about the mis-information. Of course case is not significant,
otherwise we would simply not receive these mails. I should have said
"common usage" and not "protocols", since I really thought the former
eventhough I wrote the later.

> Just because no commonly used E-Mail application seems to generate
> uppercase field names, how do you know something like a password
> auto-responder script won't?

I don't know. It's only an empirical choice based on observations. Many of us
are more concerned by hundreds of mails a day than risking to get a rare
false-positive. But I agree, I should have been clearer.

I have nearly the same .procmailrc as the one Joern Engel proposed :

  :0 D
  * ^FORM:
  spam/swen

And I too agree that I have 0% false positive so far. But just like any filter,
use at your own risk...

Willy

