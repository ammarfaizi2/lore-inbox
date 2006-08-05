Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161307AbWHEMAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161307AbWHEMAd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 08:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161308AbWHEMAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 08:00:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:18456 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161307AbWHEMAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 08:00:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XHMlGa/Ni4boPf6XSij05Qyj/LY9i8dKlyaFnFEdMcJvtOgxF+oK3JHl7SamhwTxZg7geoIuDEn2ZMysw/3Gt3zlIFCzXXJLwIEqqi/S+iI+Fyy6sISTiSPtkBW9hqngXuT8uf8hLWqI/HCu2KkZMWRnSKQm73wfZZSo1+UGazI=
Message-ID: <c526a04b0608050500j4fea20f9t825285c04a95c5c6@mail.gmail.com>
Date: Sat, 5 Aug 2006 12:00:31 +0000
From: "Adam Henley" <adamazing@gmail.com>
To: koko <citizenr@gmail.com>
Subject: Re: hda=none hda=noprobe is ignored by <=2.6.15-26
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3df49b7b0608041529k274c3c38labe52259cee555db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3df49b7b0608041529k274c3c38labe52259cee555db@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I understand it..reading Documentation/ide.txt:
"hdx=noprobe" :  drive may be present, but do not probe for it

If the CMOS/BIOS is saying there is a drive there then the kernel may
be respecting that and looking for it there...I guess that would be
why Alan gave you the response he did.

There is an option:
"hdx=none"              : drive is NOT present, ignore cmos and do not probe

Did that work for you when you tried it? It looks like that option
will explicitly ignore the CMOS.

Apologies if I'm misinterpreting the docs/misunderstanding how the
kernel works, I'm inexperienced and worse the wear for beer.

Thanks,
adam
