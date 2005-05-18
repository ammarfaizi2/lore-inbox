Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVERO07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVERO07 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVEROZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:25:47 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:3456 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262234AbVEROLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:11:00 -0400
Message-ID: <428B4CF5.1070507@ammasso.com>
Date: Wed, 18 May 2005 09:11:01 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Reply-To: linux-kernel@vger.kernel.org
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kbuild: specifying phony targets?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Makefile that works with 2.4 and 2.6 kernels.  On the 2.4 side, I have a rule 
like this:

all: mytext ${TARGET_DIR} ${TARGET_DIR}/ccil.o

mytext:
     @echo ${SOMETEXT}

This causes the text in variable SOMETEXT to be displayed right when the build starts.

How do I do the same thing with kbuild?  Is there a way I can get a kbuild makefile to run 
a phony target right at the beginning?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
