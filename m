Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWCVPmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWCVPmQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWCVPmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:42:16 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:382 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751347AbWCVPmP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:42:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C01QZ9w3a2Np5qtLzWBzFtvDHROvuRhn8teY1TZrnVire4y9ggcnhvb1xmLvCyB1hqI61+72L33yYZaU68y0xdT3EyMjVrrrE/BAGZaRO9sjRnvyG/e0gEyUCfWwN8ofRRYOEDPUMFGYQSoXnBmH7nB0j+l7d7WhqcHgQibExyU=
Message-ID: <6e0cfd1d0603220742m80e553x461362297bf38e53@mail.gmail.com>
Date: Wed, 22 Mar 2006 16:42:14 +0100
From: "Martin Schwidefsky" <schwidefsky@googlemail.com>
To: "Frank Pavlic" <fpavlic@de.ibm.com>
Subject: Re: [patch 1/6] s390: minor claw driver fix
Cc: "Jeff Garzik" <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060322162821.6ebd9af6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060322162821.6ebd9af6@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/06, Frank Pavlic <fpavlic@de.ibm.com> wrote:
> [patch 1/6] s390: minor claw driver fix
>
> From: Frank Pavlic <fpavlic@de.ibm.com>
>
>         use CONFIG_ARCH_S390X instead of CONFIG_64BIT in function dumpit .

Nack. CONFIG_ARCH_S390X doesn't exists anymore. It has been replaced
by CONFIG_64BIT in 2.6.16.

--
blue skies,
  Martin
