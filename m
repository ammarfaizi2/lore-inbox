Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUIOMvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUIOMvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUIOMvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:51:07 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:3203 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261239AbUIOMvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:51:04 -0400
Date: Wed, 15 Sep 2004 18:20:41 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       ebiederm@xmission.com, litke@us.ibm.com
Subject: kexec based crash dumping
Message-ID: <20040915125041.GA15450@in.ibm.com>
Reply-To: hari@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The patches that follow contain the kexec based crash dumping implementation.
Based on feedback received last time, we have made several changes. Some of
them are:

- The dumping kernel now boots from a non-default location. This is possible
  due to Eric's patch which allows i386 kernels to boot from a non-default
  location. This change means that we need two different kernels to get this
  setup. The documentation patch has complete details on how to do this.
- We can now choose whether or not to dump from panic. The documentation
  patch has details on this as well.
- The linear view is now called oldmem.
- Changes as per the code review comments from the previous posting.

The patches correspond to 2.6.9-rc1-mm5.

Kindly review these patches and let me know your thoughts.

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore
