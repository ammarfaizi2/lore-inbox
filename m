Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVDNAUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVDNAUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVDNAUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:20:07 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:26504 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVDNAQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:16:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qXI+qMyQR/qbgWFMAUmohSR2m33scFfmZo4AkOEp9vvkiyUHkhjnK53cYGo6CtIqPXCGHhOUxOoqFGWiA3xX9wYJNkpKfluNYRBcDnbrdctza9hd8UXHahyF0+OEY9Ym6panyyp9ScpSD8dHv9SdlhakiR3UdyqGUAVqWbAtzJM=
Date: Thu, 14 Apr 2005 02:16:43 +0200
From: Bradley Reed <bradreed1@gmail.com>
To: "Bernd Schubert" <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDR read problems with 2.6.11?
Message-ID: <20050414021643.4d72618f@galactus.localdomain>
In-Reply-To: <20050414000307.GA15733@tc.pci.uni-heidelberg.de>
References: <20050414013619.342cea4e@galactus.localdomain>
	<20050414000307.GA15733@tc.pci.uni-heidelberg.de>
X-Mailer: Sylpheed-Claws 1.9.6 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2005 02:03:07 +0200
"Bernd Schubert" <Bernd.Schubert@tc.pci.uni-heidelberg.de> wrote:

> I have seen exactly the same on my fathers computer and could solve this
> by not starting the udftools. Didn't have the time to digg further into
> this... 
> Can you confirm thats really a udf problem? Just run
> "/etc/init.d/udftools stop" or the similar for your distribution and try
> mounting again.
> 

I am not running udftools. In fact it isn't even installed (not part of
Slackware 10.1).  I'm trying to burn an iso9660 on a CDR using cdrecord.

There seems to be issues with CD burning under 2.6.11. I make an iso, and I
burn it to CDR with 2.6.11 and again with 2.4.28 on the same laptop/same DVD
+RW drive. The disk burnt under 2.4 is fine, md5sums all ok, can be read
under both kernels. The disk burnt under 2.6.11 burns without error from
cdrecord/k3b/etc, but afterwards is not readable under 2.6.11. It is readable
under 2.4.28, but the md5sums are not 100% correct, basically making 2.6.11
useless for making backups to CDR.

Brad

