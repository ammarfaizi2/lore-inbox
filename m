Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWF0VDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWF0VDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWF0VDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:03:23 -0400
Received: from pat.qlogic.com ([198.70.193.2]:55017 "EHLO avexch2.qlogic.com")
	by vger.kernel.org with ESMTP id S1030366AbWF0VDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:03:22 -0400
Date: Tue, 27 Jun 2006 14:03:19 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
Subject: keyboard repeat-rate borked with recent linux-2.6 git tree...
Message-ID: <20060627210319.GA16504@andrew-vasquezs-powerbook-g4-15.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 27 Jun 2006 21:03:22.0063 (UTC) FILETIME=[1F93E5F0:01C69A2D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Key repeats while depressing any key are broken due to the following
commits:

Input: atkbd - fix HANGEUL/HANJA keys
0ae051a19092d36112b5ba60ff8b5df7a5d5d23b

Input: fix misspelling of Hangeul key
b9ab58dd8e771d30df110c56e785db1ae5e073df

reverting 0ae051a19 fixes the lack-of-key repeats...

--
av
realizing how annoying it is to have to hit 'j' 10 times to move ten
lines...
