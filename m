Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWFVFJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWFVFJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 01:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbWFVFJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 01:09:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:57920 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932236AbWFVFJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 01:09:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=dS4u923+sLxJWUOJo1RsyVAjaSqAetr/t5fD3h/Gxk1l88cdviRjSWGgCEZJsvelpP9G1JHrXc1ITuG5LLGnNSFGC9Q13zb4jOx6g9XehR9cxFOnv8j9vVW4eNaqjuCxrm41gcodTKoMV3ULrjDv+8Ve3njGLs+lk0q/tPb8oNY=
Message-ID: <986ed62e0606212209j501e399ai34644f841b410e3e@mail.gmail.com>
Date: Wed, 21 Jun 2006 22:09:48 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: bitmap loading related reiserfs changes in 2.6.17-mm1 are broken
Cc: "Nick Orlov" <bugfixer@list.ru>, linux-kernel@vger.kernel.org,
       "Jeff Mahoney" <jeffm@suse.com>, reiserfs-dev@namesys.com
In-Reply-To: <20060621204303.47facd01.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060622032733.GA5158@nickolas.homeunix.com>
	 <20060621204303.47facd01.akpm@osdl.org>
X-Google-Sender-Auth: 65176907989270db
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/06, Andrew Morton <akpm@osdl.org> wrote:
> Yeah, sorry.  I've uploaded the below to the hot-fixes directory - it
> should repair things.

FWIW, my main -mm testing system (with a reiserfs root filesystem)
blows up during boot with 2.6.17-mm1 + the hotfix. I haven't tried
plain 2.6.17-mm1 or 2.6.17-mm1 with the reiserfs patches reverted. The
last kernel this system ran was 2.6.17-rc6-mm2, with lockdep disabled,
with no problems whatsoever.

Unfortunately I still haven't gotten around to adding a serial console
to this box *and* I do not have access to my digital camera for
approx. 2 weeks. I guess I'll try to add a serial console ASAP. This
will probably take me a day or two however.
-- 
-Barry K. Nathan <barryn@pobox.com>
