Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVAMXm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVAMXm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVAMXk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:40:26 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:19985 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261808AbVAMXaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:30:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=gHkaMuoluY0D4/QFfI0Mbw1RoVbi1C3NFojvWKYlGdlLjDDURXoMTxGA/eSiPgsgceoAhbxU22UCVBdukOpd+dzEJ9UmgEJ8LUlbeWRWIUPhOJ+uDjHzH3obM91hl6NwI4z6iFfmsoEXZeGKmZQE1Dsl6Idm7eqBfVUht9Z1fY0=
Message-ID: <8746466a050113153076e5b67d@mail.gmail.com>
Date: Thu, 13 Jan 2005 16:30:04 -0700
From: Dave <dave.jiang@gmail.com>
Reply-To: Dave <dave.jiang@gmail.com>
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       smaurer@teja.com, linux@arm.linux.org.uk, dsaxena@plexity.net,
       drew.moseley@intel.com, mporter@kernel.crashing.org
Subject: [PATCH 3/5] Convert resource to u64 from unsigned long
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_704_17263464.1105659004081"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_704_17263464.1105659004081
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is change made to i386 arch as far as I can tell that needs to be changed.

Signed-off-by: Dave Jiang (dave.jiang@gmail.com)

-- 
-= Dave =-

Software Engineer - Advanced Development Engineering Team 
Storage Component Division - Intel Corp. 
mailto://dave.jiang @ intel
http://sourceforge.net/projects/xscaleiop/
----
The views expressed in this email are
mine alone and do not necessarily 
reflect the views of my employer
(Intel Corp.).

------=_Part_704_17263464.1105659004081
Content-Type: application/octet-stream; name="patch-i386_u64fix"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-i386_u64fix"

ZGlmZiAtTmF1ciBsaW51eC0yLjYuMTEtcmMxL2FyY2gvaTM4Ni9wY2kvaTM4Ni5jIGxpbnV4LTIu
Ni4xMS1yYzEtdTY0L2FyY2gvaTM4Ni9wY2kvaTM4Ni5jCi0tLSBsaW51eC0yLjYuMTEtcmMxL2Fy
Y2gvaTM4Ni9wY2kvaTM4Ni5jCTIwMDQtMTItMjQgMTQ6MzQ6MjYuMDAwMDAwMDAwIC0wNzAwCisr
KyBsaW51eC0yLjYuMTEtcmMxLXU2NC9hcmNoL2kzODYvcGNpL2kzODYuYwkyMDA1LTAxLTEzIDEx
OjQ1OjQxLjgzMDQ2Mjc3NiAtMDcwMApAQCAtNDgsNyArNDgsNyBAQAogICovCiB2b2lkCiBwY2li
aW9zX2FsaWduX3Jlc291cmNlKHZvaWQgKmRhdGEsIHN0cnVjdCByZXNvdXJjZSAqcmVzLAotCQkg
ICAgICAgdW5zaWduZWQgbG9uZyBzaXplLCB1bnNpZ25lZCBsb25nIGFsaWduKQorCQkgICAgICAg
dTY0IHNpemUsIHU2NCBhbGlnbikKIHsKIAlpZiAocmVzLT5mbGFncyAmIElPUkVTT1VSQ0VfSU8p
IHsKIAkJdW5zaWduZWQgbG9uZyBzdGFydCA9IHJlcy0+c3RhcnQ7Cgo=
------=_Part_704_17263464.1105659004081--
