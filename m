Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVI2P0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVI2P0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVI2P0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:26:24 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:7213 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932204AbVI2P0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:26:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=UbAmR3Ta9EGCLd0zyT8hkQKvKONzAgtgsglkrK+HdSFIvY6iueqy3ck2zVqnvDOaJ4WkigCadf33m5ZVpkLhgPmnzR6qcNNRjIeAqphOWF4fCPg3YfEtAwREGUZ9IR3E4wOTkbKq1+oSeFRwMTK2UbKkTZwOGo97E2DjjqaWGmY=
Date: Thu, 29 Sep 2005 19:37:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/sparse.txt: mention CF=-Wbitwise
Message-ID: <20050929153725.GB18132@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/sparse.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/sparse.txt
+++ b/Documentation/sparse.txt
@@ -41,9 +41,9 @@ sure that bitwise types don't get mixed 
 vs cpu-endian vs whatever), and there the constant "0" really _is_
 special.
 
-Modify top-level Makefile to say
+Use
 
-CHECK           = sparse -Wbitwise
+	make C=[12] CF=-Wbitwise
 
 or you don't get any checking at all.
 

