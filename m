Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWC3Qh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWC3Qh1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWC3Qh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:37:26 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:19264 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932234AbWC3Qh0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:37:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RTK7wf5vRvr76nwCR2Oy94NFHrptnUofM7CYqch/kel/yyt6/AqW+RjIKuqNngc74HS1vB0vgEwkQimYNpTpugLdtnKA8L+aF6Yqk4yyECU00/fw8wpjQd6dLJ89E0RMCsVBJu7iW0iyGGg9Y0nVxgbGrPx1oZEU3FdpRVwzRNw=
Message-ID: <728201270603300837g60eefb65u8b55df910b86f6c4@mail.gmail.com>
Date: Thu, 30 Mar 2006 10:37:25 -0600
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "linux mailing-list" <linux-kernel@vger.kernel.org>
Subject: How to determine the start of DATA segment
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a system call or library function which a process can use to
determine the start of its data segment . I need to know the start of
the data segment so that process does not cross its DATA limit. Using
this information & sbrk it knows how much data space is already used &
how much it can grow further without crossing the limit.

Thanks
Ram Gupta
