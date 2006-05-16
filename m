Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751862AbWEPQaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbWEPQaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751856AbWEPQaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:30:21 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:13191 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751862AbWEPQaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:30:19 -0400
Date: Tue, 16 May 2006 12:30:17 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andreas Schwab <schwab@suse.de>
cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: endian fix
In-Reply-To: <jeiro6sztd.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.64.0605161230080.16908@d.namei>
References: <20060516152305.GI10143@mipter.zuzino.mipt.ru>
 <Pine.LNX.4.64.0605161149540.16379@d.namei> <jeiro6sztd.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, Andreas Schwab wrote:

> ntohs and htons are identical operations.  Either you swap or you don't,
> but there is only one way to swap a short.

Indeed.


-- 
James Morris
<jmorris@namei.org>
