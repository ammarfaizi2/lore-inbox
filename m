Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVFWMdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVFWMdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 08:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVFWMdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 08:33:05 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:2551 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S262349AbVFWMdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 08:33:01 -0400
Subject: Re: [patch 1/1] selinux: minor cleanup in the
	hooks.c:file_map_prot_check() code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: James Morris <jmorris@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1119492278.9254.32.camel@localhost.localdomain>
References: <Xine.LNX.4.44.0506222150590.10175-100000@thoron.boston.redhat.com>
	 <1119492278.9254.32.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Organization: National Security Agency
Date: Thu, 23 Jun 2005 08:31:52 -0400
Message-Id: <1119529912.28493.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-23 at 04:04 +0200, Lorenzo Hernández García-Hierro
wrote:
> El mié, 22-06-2005 a las 21:55 -0400, James Morris escribió:
> > Please send SELinux kernel patches via the maintainers.
> 
> It was sent to Stephen during the development of the execstack and
> execheap permission checks patches, but it's up to him to decide about
> it right now.
> 
> Stephen, is it OK for you?

James is correct that the first diff isn't useful (and will lead to
warnings on ppc32), whereas the latter diff is a legitimate cleanup.  So
I'd suggest resubmitting with just the latter diff.  Thanks.  Sorry for
any confusion.
 
-- 
Stephen Smalley
National Security Agency

