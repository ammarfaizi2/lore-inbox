Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbUJ1Hqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbUJ1Hqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 03:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbUJ1Hqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 03:46:33 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:23289 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262809AbUJ1Hph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 03:45:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=X4iNGmg8ygtLDQestfnMThUxiCy3ro1kiyYVPV0QCb4i2eY9H7vOzRIs6Cjj/GIs3wx1M+5fF8XXJOxSzHGQgdlTlqW23rJn6Kayiv5DKNA0kMpexJGET8rXUob02HX+69zAxNrfaAsuPh63YfDpJwMiNg34BXIwsESjGc7dI/Y=
Message-ID: <4c847c77041028004533ba6af8@mail.gmail.com>
Date: Thu, 28 Oct 2004 09:45:33 +0200
From: Craig Schlenter <craig.schlenter@gmail.com>
Reply-To: Craig Schlenter <craig.schlenter@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: status of "union mounts" and "unionfs" ?
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The following link suggests that "union mounts" and "unionfs" are
"post-2.6.0" work: http://kernelnewbies.org/status/latest.html but
from some digging through changeset comments on bkbits it would
seem as if this isn't implemented yet, right?

Are there test patches available for either of these features at all
or does someone have any other clever suggestions as to how
to netboot a bunch of machines that share pretty much the same
filesystem image over NFS except for some "machine specific
differences"?

Thank you!

PS. I have read the whitepaper for "Stateless Linux" but it doesn't
really seem like an ideal fit for what I want to do ...

--Craig
