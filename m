Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVHWHS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVHWHS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbVHWHS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:18:57 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:30578 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750839AbVHWHS4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:18:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tddOU02IXlhjXHbi/r96G0eVxQ9lMmVWJyKOxvqPeR8kaj753MUpfACtAMgJSXxJsOyXd2mHyv7hvouEz7y13WY1XMd/Yor9bP9tYzvNvmLNSBbWHdJjhxSedbeSkAjDXwymGy1wpMWVpoR5FpAGtRuqc4e0uLu2ytzTvQIhwRM=
Message-ID: <2cd57c90050823001855403664@mail.gmail.com>
Date: Tue, 23 Aug 2005 15:18:51 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [proposal] remove struct file *file from aops
Cc: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The argument struct file *file in aops { .readpage, .readpages,
prepare_write, .commit_wirte } is not used.  I'd like to file a series
of patches to clean it up. Are there any other concerns?

thanks
-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
