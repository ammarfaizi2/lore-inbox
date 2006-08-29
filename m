Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWH2OPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWH2OPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWH2OPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:15:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:6043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964985AbWH2OPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:15:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lCB2HrfJoz3VmNFK1fXHtbhuODxZ052Lb7x+xRzCCGvFp1WuXHXH288k+XVjgbsgjZ1z8WaOoALLawDLH8WELqq2XO1lKiCt3u5FmSCf75cYNWvlOV5kAlVaqVXq4ejDoW5FxgS+Qk1wMlfhEjJwUZRRbf258YvQwOZvmyMMtLg=
Message-ID: <a2ebde260608290715o627c631uca67e5b84b8c0777@mail.gmail.com>
Date: Tue, 29 Aug 2006 22:15:19 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Andi Kleen" <ak@suse.de>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Dong Feng" <middle.fengdong@gmail.com>,
       "Paul Mackerras" <paulus@samba.org>,
       "Christoph Lameter" <clameter@sgi.com>,
       "David Howells" <dhowells@redhat.com>
Subject: The 3G (or nG) Kernel Memory Space Offset
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel permenantly map 3-4G linear memory space to 0-4G
physical memory space. My question is that what is the rationality
behind this counterintuitive mapping. Is this just some personal
choice for the earlier kernel developers?
