Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVLGDis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVLGDis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 22:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVLGDis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 22:38:48 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:35130 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964842AbVLGDir convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 22:38:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oWCHG+KQHLWR5SozyrVQj+s2JijgzWMDe+aJUZl3OhLHzDYxgYWoaJyqSgfmpyaydTWkCoL6DPfYDpgmjvIMo/2iIBbqAaoG7EDwJBXrasQTsvQCEJnDdQpd+jn3x3ddbhQ1z8sFlgnDftugcDomzTHLPs573pzvozs1sZtZDaA=
Message-ID: <afd776760512061938w7647b155r28a9eef8fdcfb640@mail.gmail.com>
Date: Tue, 6 Dec 2005 21:38:46 -0600
From: Mohamed El Dawy <msdawy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Load-on-demand. How does the kernel locate the pages on secondary storage?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 Assume we have a process running, not all the pages of the process
are in main memory. Some are swapped, and some are just not loaded
yet.
How does the kernel locate those pages on disk? Is there a pointer in
the page table? or is there some place else? Any pointers to source
code in the kernel would be greatly appreciated.

Thank you very much.
