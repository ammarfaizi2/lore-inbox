Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUDNVcD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUDNVcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:32:03 -0400
Received: from florence.buici.com ([206.124.142.26]:37255 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261766AbUDNVcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:32:02 -0400
Date: Wed, 14 Apr 2004 14:32:00 -0700
From: Marc Singer <elf@buici.com>
To: linux-kernel@vger.kernel.org
Subject: Can I map from a PTE to a struct page?
Message-ID: <20040414213200.GA4515@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm debugging a problem where an NFS transfer is causing a program
code page to be evicted.  I'd like to look at the struct page before
it is culled.  How would I go about finding the page corresponding to
a PTE?

