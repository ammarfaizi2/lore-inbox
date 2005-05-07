Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263152AbVEGOFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbVEGOFt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 10:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbVEGOFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 10:05:49 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:26151 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263152AbVEGOFp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 10:05:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hPxLTMeMnQOaCYRJoigYwkk/gkONsLTUd5D2ASIqmYket6oELnEGrqxZTrm5NExhTmVW5kBK/jm/fNBDoNtgl7STX0Vm5wGgGgIcgfC+YsNnwJ81iRlOO6LwbX198Ngtw1IaMxHcIl4Du+0meBtkhhj48aBFhPRdDOl52aigtig=
Message-ID: <7aaed091050507070532227f30@mail.gmail.com>
Date: Sat, 7 May 2005 16:05:39 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
Reply-To: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
To: li nux <lnxluv@yahoo.com>
Subject: Re: compiling "hello world" kernel module on 2.6 kernel
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20050507131928.10643.qmail@web60519.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050507131928.10643.qmail@web60519.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/05, li nux <lnxluv@yahoo.com> wrote:
> 
> default:
>          $(MAKE) -C $(KERNELDIR) M=$(PWD) modules

Try changing this to:
" $(MAKE) -C $(KERNELDIR) SUBDIRS=$(PWD) modules"


-- 
Mvh / Best regards
Espen Fjellvær Olsen
espenfjo@gmail.com
Norway
