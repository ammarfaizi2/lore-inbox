Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTKVIai (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 03:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbTKVIai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 03:30:38 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:47884 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262131AbTKVIah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 03:30:37 -0500
Date: Sat, 22 Nov 2003 08:30:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Michael Welles <mike@bangstate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using get_cwd inside a module.
Message-ID: <20031122083035.A30106@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
References: <3FBEA83B.1060001@bangstate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FBEA83B.1060001@bangstate.com>; from mike@bangstate.com on Fri, Nov 21, 2003 at 07:05:15PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The basic problem is that you shouldn't call syscalls from kernelspace.
Have you looked at dnotify to look for changed files instead?

