Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVDQPyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVDQPyo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 11:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVDQPyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 11:54:43 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:29485 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261339AbVDQPyh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 11:54:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GOLilCD2PNXz2HBaYaZ+8pZfKQa7tp/ijew6bJ/SORjIXYZJwV8tgI2kuwms7ONsxKvJvmnbzuRZM/TmuZfqgrsq5dCOqz5wD1MNV5/Y5MeFAwDLa1UZP0qLF1tAVSut5SJZl9JIhiBhkZQZuriO2h3vT1t3N86rDouDEXnkjMU=
Message-ID: <4ae3c14050417085473bd365f@mail.gmail.com>
Date: Sun, 17 Apr 2005 11:54:34 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Why Ext2/3 needs immutable attribute?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why not simply unset the write bit for all three groups of users? 
That seems to be enough to prevent file modification.

Immutable seems to only add one more protection level in case of
misconfiguration on standard access right bits.  Is that right?
