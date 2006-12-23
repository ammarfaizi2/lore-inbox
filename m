Return-Path: <linux-kernel-owner+w=401wt.eu-S1753262AbWLWLMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbWLWLMF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 06:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbWLWLMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 06:12:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45236 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbWLWLME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 06:12:04 -0500
Subject: Re: io_submit delay problems revisited
From: Arjan van de Ven <arjan@infradead.org>
To: Patrick Reynolds <reynolds@cs.duke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0612221816590.9502@miro.cs.duke.edu>
References: <Pine.LNX.4.63.0612221816590.9502@miro.cs.duke.edu>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 23 Dec 2006 12:12:01 +0100
Message-Id: <1166872322.3281.621.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-22 at 22:16 -0500, Patrick Reynolds wrote:
> I believe that io_submit() blocks when it shouldn't.  I have read the two
> recent LKML threads on the subject.

> Any ideas?
> 

AIO to files isn't actually asynchronous (with the possible exception of
O_DIRECT opened files).....

 
> --Patrick
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

