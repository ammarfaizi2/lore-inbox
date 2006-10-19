Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946233AbWJSSdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946233AbWJSSdB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946317AbWJSSdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:33:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:4330 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946233AbWJSSdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:33:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=lwaG7Tx896zeFqgjQZzazALACq/7BhVXPrV26WoC+6DjmwX0XqXG3Atonu8Q2saCs4zSSlFeqpPlv8DL6vko4WKODfLJjOCmBX1OU3P1vPAfQJXbRdQg4XQqthRKAUd4SX3ct8Bi2sqnSNJhaPzoq9zQjKMkIvaXq1YjVDEzEJ4=
Message-ID: <4537C4CC.7020902@gmail.com>
Date: Thu, 19 Oct 2006 11:32:44 -0700
From: David KOENIG <karhudever@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pci_[g|s]et_drvdata() versus ->driver_data
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is there any reason for some drivers that I should leave references as
foo->driver_data instead of pci_get_drvdata(foo)?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFN8TLmhCgVPlWJY8RAv4lAJ9VrJg+DlXt+AMvVBBbMSgl/3UqzgCgpynk
cGm7n7hfEdgWZQxZ0qeXhqE=
=0KXz
-----END PGP SIGNATURE-----
