Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVDEKGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVDEKGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 06:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVDEKCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 06:02:21 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:46369 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261683AbVDEJ6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:58:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=iE4TteRBA9qprDQBRNekGWk88uZm49pDCWw18vEKKPgbqByiKOTqP1I0SJu6nmW4UV2Ghu33e83VI5VY9NDv+PgHPcu5iC8P/Pi+A9xVMrpyfh4YVDiU09nKc2SLhuIleS2eZTT9gftAmcr/2TD/PkdutVZzdOS4GQx3gBHFuh8=
Message-ID: <21d7e99705040502584229ae8d@mail.gmail.com>
Date: Tue, 5 Apr 2005 19:58:19 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Paul Mackerras <paulus@samba.org>,
       Dave Airlie <airlied@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
In-Reply-To: <20050405095445.GA29246@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050405000524.592fc125.akpm@osdl.org>
	 <20050405074405.GE26208@infradead.org>
	 <21d7e99705040502073dfa5e5@mail.gmail.com>
	 <16978.22617.338768.775203@cargo.ozlabs.ibm.com>
	 <20050405093020.GA28620@infradead.org>
	 <16978.24070.786761.641930@cargo.ozlabs.ibm.com>
	 <20050405094535.GA29095@infradead.org>
	 <16978.24509.527688.799274@cargo.ozlabs.ibm.com>
	 <20050405095445.GA29246@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> E.g. on my ia64 box CONFIG_COMPAT is set because I have support compiled
> in for running i386 apps.  But I don't want dri to hand out 32bit handles
> everywhere just because of that, because I most certainly won't be running
> i386 OpenGL apps.
> 

It doesn't actually matter what size the handles are from what I
understand of this... as long as they are hashed properly.. I've been
thinking of changing the handle from something with meaning to a hash
just to find out some more bugs.. even on plain 32-bit systems..

Dave.
