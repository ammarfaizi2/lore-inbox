Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbTA2ET5>; Tue, 28 Jan 2003 23:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbTA2ET5>; Tue, 28 Jan 2003 23:19:57 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1616 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262871AbTA2ET5>; Tue, 28 Jan 2003 23:19:57 -0500
To: "Fu, Michael" <michael.fu@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] e100 driver fails to initialize the hardware after ker nel bootup through kexec
References: <957BD1C2BF3CD411B6C500A0C944CA2602E947F0@pdsmsx32.pd.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jan 2003 21:28:33 -0700
In-Reply-To: <957BD1C2BF3CD411B6C500A0C944CA2602E947F0@pdsmsx32.pd.intel.com>
Message-ID: <m1adhk60lq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Fu, Michael" <michael.fu@intel.com> writes:
> 
> Jeff,
> 
> Which release your patch applies for ? I failed to compile it on 2.5.52. It
> seems that function e100_disable_clear_intr is not defined.

Fu?  Why are you working against 2.5.52?  kexec should be fine
against later kernels.

Eric
