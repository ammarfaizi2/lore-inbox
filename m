Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbTBUSrn>; Fri, 21 Feb 2003 13:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267524AbTBUSrn>; Fri, 21 Feb 2003 13:47:43 -0500
Received: from mnh-1-11.mv.com ([207.22.10.43]:9221 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267466AbTBUSrm>;
	Fri, 21 Feb 2003 13:47:42 -0500
Message-Id: <200302211850.NAA02810@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: uml-patch-2.5.62-1 
In-Reply-To: Your message of "Thu, 20 Feb 2003 11:08:51 +0300."
             <20030220110851.A1069@namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Feb 2003 13:50:33 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

green@namesys.com said:
> That hunk below from your diff adds add_disk() call. Notice how a bit
> down we have another  call to add_disk(), that is not removed. So we
> end up woth two add_disk() calls. Of course sysfs gets upset
> immediately (probably not only it). 

Oops, fixed.

		Jeff

