Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424139AbWKIRFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424139AbWKIRFF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424135AbWKIRFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:05:05 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:55357 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1424137AbWKIRFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:05:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kC+zpd497ytXzBxPtVD4eVmsirlqylUjXEg3wCJUmjR63SE40IzLrDD65WKoUR1XxWe4/2hwt/37MegccxzKw1hlqDqoMWJ34779zprnoQopqWzqwCi9jqiBCBOw4ne6Rr4Y+kxfS4bkyP6TDHB3FaYjy06n2HV4ct+RD1H6wJ0=
Message-ID: <86802c440611090905j780b9877x80aaa1b7f2ddf3dd@mail.gmail.com>
Date: Thu, 9 Nov 2006 09:05:01 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Don Zickus" <dzickus@redhat.com>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Cc: ebiederm@xmission.com, "Fastboot mailing list" <fastboot@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061109163922.GE5622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com>
	 <20061109163922.GE5622@redhat.com>
X-Google-Sender-Auth: 34ec287b0ff92416
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just start from rc4 around.

YH

On 11/9/06, Don Zickus <dzickus@redhat.com> wrote:
> On Wed, Nov 08, 2006 at 08:07:22PM -0800, Lu, Yinghai wrote:
> > Eric,
> >
> > I got "Invalid memory segment 0x100000 - ..."
> > using kexec latest kernel...
>
> I usually see this when people forget to add the "crashkernel=X@Y" into
> their /etc/grub.conf kernel command line.  Where X and Y are arch
> specific.
>
> Cheers,
> Don
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
