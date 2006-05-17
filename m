Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWEQM5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWEQM5w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWEQM5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:57:52 -0400
Received: from e-nvb.com ([69.27.17.200]:5260 "EHLO e-nvb.com")
	by vger.kernel.org with ESMTP id S932067AbWEQM5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:57:51 -0400
Subject: Re: Kernel vs drivers releases?
From: Arjan van de Ven <arjan@infradead.org>
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7024640@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
References: <8E8F647D7835334B985D069AE964A4F7024640@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Content-Type: text/plain
Date: Wed, 17 May 2006 14:56:51 +0200
Message-Id: <1147870632.3051.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Am I completely wrong?

I think you are yes ;)
You seem to assume you can separate drivers from the kernel. In linux,
drivers are a full member of the kernel, which really can't be
separated. Or in more technical terms: there is no stable API between
drivers and the kernel that separates them. Drivers are an integral
part, not something that can be chopped off and kept separate. Not all
operating systems do it that way. but linux does, and the reasons for
that have been discussed to death on this list many times (there is even
a file in Documentation/ about it). But given that situation.. the
separation you propose makes no sense.



