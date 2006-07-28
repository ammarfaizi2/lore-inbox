Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161201AbWG1Rhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161201AbWG1Rhg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161203AbWG1Rhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:37:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:8004 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161201AbWG1Rhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:37:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QtYFf9nbg8iIcVj+GiukYWu2A3QUz2zhGcRyBe9OxH+UY15i/LlG3b0+pVo6alGmscRrivLmYzTmKCt/cIvYsVaT9SM2WQhsLFxwyq2NqYW+CiOtYiK+apwCCD0V+wilG2zU03dR/zG6m2LOMkxThNrha00RuYTj1qAVlYFvN0o=
From: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Date: Fri, 28 Jul 2006 10:37:27 -0700
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mtosatti@redhat.com
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200607271521.38217.benjamin.cherian.kernel@gmail.com> <20060727164951.ada33ed5.zaitcev@redhat.com>
In-Reply-To: <20060727164951.ada33ed5.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607281037.28328.benjamin.cherian.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,
Thanks for the reply.
> By the way, you didn't tell me if you tried to use alarm(2) across
> submitted URBs. This is the technique ADSL modem drivers use. They
> also have to have input and output streams running simultaneously.

I'm making a library to operate my device, and I don't want to use alarm, 
because the user might need to use alarm in his own applications.

Thanks again,
Ben

