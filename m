Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbVCDP3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVCDP3j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVCDP3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:29:38 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:19077 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262942AbVCDP2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:28:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Lx3x+K/xPLJV/G7e/e6A6329M780JidGeiXz+t2ZQ/6Mn3pJnVtQ12nCo0dXu4hfbwAMFebSfQQO3zErcugB9+a+YyPotdhi94G4nf2aVvrE5u0WE87LTln2MVQ6FRKTteggHkWHuBeu1sss/l0259faBvDarzA9hawFb+w9eIU=
Message-ID: <d120d500050304072741f15701@mail.gmail.com>
Date: Fri, 4 Mar 2005 10:27:58 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: bennie.venter@shoden.co.za
Subject: Re: v.2.6.11 mouse still losing sync and thus jumping around
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42286F2B.3030500@shoden.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <42271D31.8060006@shoden.co.za>
	 <200503031543.53065.dtor_core@ameritech.net>
	 <422822DA.2050501@shoden.co.za> <42286F2B.3030500@shoden.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Mar 2005 16:22:35 +0200, Bennie Kahler-Venter
<bennie.venter@shoden.co.za> wrote:
> Oops - made a small mistake - new patch
> 
> Find attached the updated psmouse-resend patch for 2.6.11.
> 
> It fixes most of the lost-sync problems for the ps2 mouse but not all of
> them.  I might have picked the wrong struct members for v.2.6.11
> 

Please do not use this patch - it looks it based on one of the earlier
versions and may cause mouse disappear if it signals timeout
condition.

I am not quite sure why you could not compile with the patch I sent. I
have just applied it to vanilla 2.6.11 tree and it was built just
fine. In case my patch somehow got mangled onl its way to you try
grabbing one from here:

    http://www.geocities.com/dt_or/input/2_6_11/

-- 
Dmitry
