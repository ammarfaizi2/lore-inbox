Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVG0SiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVG0SiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVG0Sf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:35:29 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:41636 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261290AbVG0Seo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:34:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=e7ZhqQUE4o9tEhbBBmBh8NcBitjb/HKi7hJyVtgQySYGAQfIoB6MocPVQq2QO3GcxODzrtBl+29dHOOlHegO6QENBwcALkGA7IKIR/rGd33+Eem6YdRlNdJjCdhi3ew1cHNvXa4VsonRbYV4+E68AbbFkYMpeN30H8oF/74oP8g=
Message-ID: <90f56e4805072711341bc156d9@mail.gmail.com>
Date: Wed, 27 Jul 2005 11:34:43 -0700
From: Ajay Patel <patela@gmail.com>
Reply-To: Ajay Patel <patela@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ppc: Sungem auto-negotiation problem
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a PowerMac G5. (Newer Model with SMU).
It has a  Sungem ethernet with "PHY ID: 2060d2".

When this ethernet is connected to 
"Tigon3 [partno(BCM95704A6) rev 2002 PHY(5704)] " or
to the cisco switch, The PowerMac declares link up with
100 Mbs, while the other end declares link up  with 1000Mbs.
In this setup both end cannot ping each other.

If I lower the speed of Tigon based adapter or Cisco's switch
port to 100Mbs, both end can ping each other.

Is it a bug? or Am I missing something?

Thanks in advance for the help.
Ajay
