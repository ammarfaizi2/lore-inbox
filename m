Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbTCQMVv>; Mon, 17 Mar 2003 07:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261667AbTCQMVu>; Mon, 17 Mar 2003 07:21:50 -0500
Received: from mail.tammen.info ([62.225.14.106]:48399 "EHLO mail.tammen.de")
	by vger.kernel.org with ESMTP id <S261664AbTCQMVt>;
	Mon, 17 Mar 2003 07:21:49 -0500
From: Heinz Ulrich Stille <hus@design-d.de>
Organization: design_d gmbh
To: linux-kernel@vger.kernel.org
Subject: Re: Read Hat 7.3 and 8.0 compilation problems
Date: Mon, 17 Mar 2003 13:32:33 +0100
User-Agent: KMail/1.5
References: <001d01c2ec83$6bfbcc10$e9bba5cc@patni.com>
In-Reply-To: <001d01c2ec83$6bfbcc10$e9bba5cc@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200303171332.34982.hus@design-d.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 March 2003 13:47, chandrasekhar.nagaraj wrote:
> are compiling the same driver on Red Hat 7.3 and 8.0
> While compiling we are facing the following problems.
> Compilation output :-
> The following files are missing
> /usr/include/asm/msr.h

Are you using the stock rh kernel sources? Did you install the
glibc-kernheaders RPM? This contains severe RedHat braindamage:
/usr/include/{asm,linux} aren't links into the kernel source tree,
but directly installed. Remove the rpm and create the soft links
to /usr/src/linux.

MfG, Ulrich

-- 
Heinz Ulrich Stille / Tel.: +49-541-9400463 / Fax: +49-541-9400450
design_d gmbh / Lortzingstr. 2 / 49074 Osnabrück / www.design-d.de

