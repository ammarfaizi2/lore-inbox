Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWBVTWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWBVTWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWBVTWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:22:38 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:18111 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751055AbWBVTWh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:22:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mXYGX/Ihrm5wLMe50pcmWGyJmwCdjO7YSlhSh77wrQsc8poVn/USWfBO7jLsXWYB2DCdKJ+i6SgEfTl9IgbAoVviM3/SuKbbWOMtKztFHHgLAVOctcR2b69jNgbagaXvQKvf0HWWrDPnp2RpHNwW0yNkx3040NIyNGBsHSc3I2Y=
Message-ID: <5b5833aa0602221122q7a93b07an2a4ad7978caccdbb@mail.gmail.com>
Date: Wed, 22 Feb 2006 15:22:36 -0400
From: "Anderson Lizardo" <anderson.lizardo@gmail.com>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Subject: Re: Git via a proxy server?
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F022DD553@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F022DD553@otce2k03.adaptec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/06, Salyzyn, Mark <mark_salyzyn@adaptec.com> wrote:
> [...]
> Doesn't even appear to hit the proxy server. MIS had opened up the port
> directly as a test using:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/
>
> worked fine, but it can not be a permanent arrangement. They have the
> same port on the proxy server set up as well, but the logs indicate zero
> hits.

Hi,

Try using the HTTP protocol. It's slower but usually works fine under
HTTP proxies:

export http_proxy=proxyserver:8080

git clone http://git.kernel.org/pub/scm/linux/kernel/git/jejb/

Regards,
--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
