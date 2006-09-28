Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWI1Rhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWI1Rhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWI1Rhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:37:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:27714 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932521AbWI1Rhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:37:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=epmVAof7Nqn7kQ+m5NH+cmUconGQhs39opwWqRH2isVSHu+sBFltv6hY8HyGMn5NFwDuRmN8Kq9DbBeWCYP9obq8sp1VfijQZtBW+kEAVSvUrU2RUhhlaAOUe7MDeKO1yak3UcFET9vDHgfd6ovIjQybLNWJdWU6ktvADpCSXcA=
Message-ID: <29495f1d0609281037xf40f12do525ecb29696f0d13@mail.gmail.com>
Date: Thu, 28 Sep 2006 10:37:34 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Martin Bligh" <mbligh@google.com>
Subject: Re: [PATCH] fix compiler warning in drivers/media/video/video-buf.c
Cc: "Andrew Morton" <akpm@osdl.org>, "Sujoy Gupta" <sujoy@google.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <451C070E.8080800@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <451C070E.8080800@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/06, Martin Bligh <mbligh@google.com> wrote:
> Using a double cast to avoid compiler warnings when
> building for PAE. Compiler doesn't like direct casting
> of a 32 bit ptr to 64 bit integer.
>
> From: Sujoy Gupta <sujoy@google.com>

I believe this is supposed to be the first line in the mail?

> Signed-off-by: Martin J. Bligh <mbligh@google.com>

Thanks,
Nish
