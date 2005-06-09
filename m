Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVFIRlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVFIRlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 13:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVFIRlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 13:41:18 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:61252 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262422AbVFIRlO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 13:41:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ksO7/3jsSqehhbtJz4ss18SDdCoW62ck7VwlZ0K46NPj8Gfg2hqfBn1dr9oWIU11miGq1/fhgrtJ/XzsQx87L5FwWzksxKtDg/F+tbvkF80W11+XvkYBJyFOaNnPkuX6hHk7D0V9FMD6pYYfM7qhSUjOXHmEj+atp2moT5qMUzY=
Message-ID: <84144f020506091041162df804@mail.gmail.com>
Date: Thu, 9 Jun 2005 20:41:14 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [RFC] SPI core
Cc: dpervushin@ru.mvista.com, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <200506092019.50210.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
	 <84144f020506090533b00b823@mail.gmail.com>
	 <200506092019.50210.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 09 June 2005 16:33, Pekka Enberg wrote:
> > Preferred location for EXPORT_SYMBOLs is immediately after the function
> > definition.

On 6/9/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> New files can choose any style.

Sure they can but hopefully they choose a style that make sense.
Putting EXPORT_SYMBOLs immediately after function definition makes
most sense to me. You can immediately see if a function is exported or
not plus you can get listing of all symbols with grep. So there's
really no good reason why you should put them at the end of a file
(and one good reason to put them after definition).

You are right, though, that authors and maintainers decide what style
they use. I only provide suggestions and hope for the best ;).

                                       Pekka
