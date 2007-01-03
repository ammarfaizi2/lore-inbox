Return-Path: <linux-kernel-owner+w=401wt.eu-S1750869AbXACPYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbXACPYO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 10:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbXACPYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 10:24:13 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:44534 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbXACPYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 10:24:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QCtwJRuf4nJ71q2wdmsK/n/Lm34ODKNIt09EpZj0tu+TugXUNtOcbdT+d2vEPdaNTSa7lWV0Q8XlsQv+YuHZhdOZgg0FNXgaHdPGb7Mco5Lef31d589FpVK0HzVWefIiBUt4n/lbRAT5r86ADqsG+d6X0yUcHgJrVX5hz9hGrpg=
Message-ID: <6bb9c1030701030724k4ca544cfg364e28059cf5dfe@mail.gmail.com>
Date: Wed, 3 Jan 2007 16:24:11 +0100
From: "Pelle Svensson" <pelle2004@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Symbol links to only needed and targeted source files
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to set up a directory with only links to the source files
I use during the building of the kernel. The development ide/editor
will target this directory instead of main source tree. The benefit of this
is that I don't need to bother about files that are not included
by the configuration.

Can I do this by something like....

make linked_directory

If not, what part of make is a good starting point?

/Pelle
