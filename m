Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVDIBJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVDIBJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVDIBJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:09:28 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:31337 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261227AbVDIBJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:09:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=fympwXWS/6SiZ5EqX1DZzxUjeZc2KozxYpF0sgVoptzoNhVRH53/uUGDTY7tKgGDT7COUA2m/4IEsEni2Q1tE1seis1Px7gqYcza/Kq1S6uCOD+9DAJHNza7knNa159DaVA/E7LUpM1eEVbXDFXS9p7GLd1XfJCixrr19qvHgn8=
Message-ID: <40f323d005040818095eb63950@mail.gmail.com>
Date: Sat, 9 Apr 2005 03:09:09 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: const qualifiers on function returns type
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there are some function who are declared this way:

include/linux/cpuset.h:21
extern const cpumask_t cpuset_cpus_allowed(const struct task_struct *p);

I was wondering what means const for a function returns type.
K&R doesn't say anything about this and gcc-4 warns (warning: type
qualifiers ignored on function return type)

If it is a mistake, there are a few functions who should be modified.

Regards,

Benoit
