Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263834AbRFLXd4>; Tue, 12 Jun 2001 19:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263851AbRFLXdr>; Tue, 12 Jun 2001 19:33:47 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:27008 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S263834AbRFLXdd>; Tue, 12 Jun 2001 19:33:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "Craig Lyons" <craigl@promise.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Getting A Patch Into The Kernel
Date: Tue, 12 Jun 2001 14:32:31 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <005101c0f38f$e2000960$bd01a8c0@promise.com>
In-Reply-To: <005101c0f38f$e2000960$bd01a8c0@promise.com>
MIME-Version: 1.0
Message-Id: <01061214323100.01850@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 June 2001 18:34, Craig Lyons wrote:

> We have a patch that fixes this and are wondering if it
> is possible to get this patch into the kernel, and if so, how this would be
> done?

Well, you start by reading this:

http://www.linuxhq.com/kernel/v2.4/doc/SubmittingPatches.html

Which basically says that you post it here, with a title along the lines of:

"[PATCH] promise IDE raid support".

Start the body of your email with a brief description of the patch (the above 
is fine, mentioning that this is an official patch from promise is nice), and 
then include the patch itself at the end of the email in plain text.  (Linus 
won't read Mime attachments, although others sometimes do and forward them to 
him.  Sometimes.)

You do know how to make a unified diff using "diff -u", right?  (I'm assuming 
you have an includeable patch already prepared?)

Also, try to use an email program that doesn't mangle whitespace.  (It's a 
nit-pick, but it's good hygiene.)  The difference between spaces and tabs is 
generally considered to be a good thing to maintain.

Rob
