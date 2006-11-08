Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161689AbWKHTFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161689AbWKHTFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161692AbWKHTFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:05:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:26544 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161689AbWKHTF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:05:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q4jQJ72kI8u+gXF3TT6GAT8D93CVQqfhqG4CJmd4WjUS59HBpi2cdrK3H3mTNhisko5gI1wejtpKrbDuhkdcySCdpeAfi37rUZPjSOHRlIbA8JkgCFSwW2k4eB+8Y/UFlA1JhGTo5uNAi90yTUq2Q07bJZvqfyg38lNYQWFf7bE=
Message-ID: <9a8748490611081105j5ca1d24ahd49c6d9ea7d980d3@mail.gmail.com>
Date: Wed, 8 Nov 2006 20:05:27 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: Re: How to compile module params into kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D939AA94F9@tmnt04.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <F6AD7E21CDF4E145A44F61F43EE6D939AA94F9@tmnt04.transmode.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> Instead of passing a module param on the cmdline I want to compile that
> into
> the kernel, but I can't figure out how.
>
> The module param I want compile into kernel is
> rtc-ds1307.force=0,0x68
>
> This is for an embeddet target that doesn't have loadable module
> support.
>
You could edit the module source and hardcode default values.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
