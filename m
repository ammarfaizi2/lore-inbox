Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUIMIqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUIMIqi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 04:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUIMIqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 04:46:38 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:64129 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S266477AbUIMIqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 04:46:17 -0400
Message-ID: <414570B2.2060207@cs.auc.dk>
Date: Mon, 13 Sep 2004 12:04:34 +0200
From: =?ISO-8859-1?Q?S=F8ren_N=F8hr_Christensen?= <snc@cs.aau.dk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: d_path crashes on boot!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I'm working on a security project, where we need to get full paths of 
accessed files. We are using the function d_path, and it works. Problem 
occurs if we call the function during a boot, this makes the kernel 
crash instantly.

Is there another way around the problem, or is there a way to check for 
some defines, so that d_path is not called until the datastructures are 
ready?

//snc
