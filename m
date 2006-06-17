Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWFQAYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWFQAYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 20:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWFQAYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 20:24:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:56965 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932493AbWFQAYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 20:24:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QS74YvsaVyF/mfvvB0IbuZsJTDYUTUoQwwqum5IDAaLdCEQtTX6CxEJ0YASm81yX7L9MV40tJTWweViqfLhgqGDQRST3C1w2nUl6gDXOE/2n1qm6Xr1/5tOJyPQSbZXCyoQzGgIqmlUMQrurktYCxHLdT9gKQptS2ZC/nvSh8Wk=
Message-ID: <bda6d13a0606161724r61993c0aga7b34d434164c784@mail.gmail.com>
Date: Fri, 16 Jun 2006 17:24:52 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 00/20] Mount writer count and read-only bind mounts (v2)
In-Reply-To: <Pine.LNX.4.63.0606170202020.14464@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060616231213.D4C5D6AF@localhost.localdomain>
	 <Pine.LNX.4.63.0606170125110.14464@alpha.polcom.net>
	 <1150501318.7926.22.camel@localhost.localdomain>
	 <Pine.LNX.4.63.0606170202020.14464@alpha.polcom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just document it and it will be OK.

Better yet, remember that you are probably setting up the bindings
before you start the processes in the untrusted area. Probably don't
have to do a thing in that case.

Maybe mount can do this automagically <g>
