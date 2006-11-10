Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424331AbWKJBHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424331AbWKJBHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424324AbWKJBHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:07:54 -0500
Received: from koto.vergenet.net ([210.128.90.7]:47009 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1424331AbWKJBHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:07:53 -0500
Date: Fri, 10 Nov 2006 09:47:48 +0900
From: Horms <horms@verge.net.au>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: yhlu <yinghailu@gmail.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Message-ID: <20061110004747.GA4107@verge.net.au>
References: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com> <20061109054805.GA28415@verge.net.au> <2ea3fae10611082204k5316379fsd33a33954c58ab4b@mail.gmail.com> <20061109062124.GB28415@verge.net.au> <86802c440611082336l26ad9c94i49e805097c3a00b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440611082336l26ad9c94i49e805097c3a00b4@mail.gmail.com>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 11:36:16PM -0800, Yinghai Lu wrote:
> .  ..  AUTHORS  config  configure.ac  COPYING  doc  .git  include
> kdump  kexec  kexec_test  kexec-tools.spec.in  Makefile
> Makefile.conf.in  News  purgatory  TODO  util  util_lib
> yhlunb:/home/yhlu/xxx/xx/kernel/kexec-tools-testing # make
> Makefile:2: Makefile.conf: No such file or directory
> util_lib/Makefile:10: /util_lib/compute_ip_checksum.d: No such file or 
> directory

You need to run ./configure before you run make,
I think that will make your problem go away

# ./configure && make

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

