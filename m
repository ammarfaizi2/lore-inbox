Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWBTO5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWBTO5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWBTO5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:57:14 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:36053 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030268AbWBTO5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:57:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=R2sjIx/+MM3TQwQEX+UX/x5dMqSOwF3m+um6FlzS7qUqrQFGNZSXGGQtci/VrdV+FfAgTwFu+VVEwUbZmLx3hAw2uYL+UF+P1b4E4ruOGAtBoZZ9FwXzEa3NlC5Sj7cSx4o+cHTkvd/vohXbDSaiJuQZAk4cd0065k2GVJDiy60=
Date: Mon, 20 Feb 2006 17:57:03 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mempolicy.c: fix 'if ();' typo
Message-ID: <20060220145703.GA8200@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 mm/mempolicy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -587,7 +587,7 @@ redo:
 		}
 		list_add(&page->lru, &newlist);
 		nr_pages++;
-		if (nr_pages > MIGRATE_CHUNK_SIZE);
+		if (nr_pages > MIGRATE_CHUNK_SIZE)
 			break;
 	}
 	err = migrate_pages(pagelist, &newlist, &moved, &failed);

