Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWFONiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWFONiT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 09:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbWFONiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 09:38:19 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:16851 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1030401AbWFONiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 09:38:18 -0400
From: Janne Karhunen <Janne.Karhunen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: NFSv3 client reordering RENAMEs
Date: Thu, 15 Jun 2006 16:38:15 +0300
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606151638.15792.Janne.Karhunen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'd day,

Looks like that given async NFS mount Linux NFS client can reorder
RENAMEs as well. For me this caused several eaten files :/. Didn't
really expect RENAME to be reordered as mv is generally considered
atomic. That, and RFC 1813 mandates RENAME to be atomic. Is this a
known thing and do you guys consider this feature or a bug?


-- 
// Janne
