Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291384AbSBSM5Q>; Tue, 19 Feb 2002 07:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291386AbSBSM5H>; Tue, 19 Feb 2002 07:57:07 -0500
Received: from deborah.paradise.net.nz ([203.96.152.32]:19471 "HELO
	deborah.paradise.net.nz") by vger.kernel.org with SMTP
	id <S291384AbSBSM4y>; Tue, 19 Feb 2002 07:56:54 -0500
Message-ID: <3C724B02.CDF8F71F@paradise.net.nz>
Date: Wed, 20 Feb 2002 01:54:26 +1300
From: Jens Schmidt <j.schmidt@paradise.net.nz>
X-Mailer: Mozilla 4.61 [en] (OS/2; U)
X-Accept-Language: en-GB,en
MIME-Version: 1.0
To: Jan-Frode Myklebust <janfrode@parallab.uib.no>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: secure erasure of files?
In-Reply-To: <200202121326.g1CDQct12086@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.30.0202121431560.18694-100000@mustard.heime.net> <20020217211947.GA17457@ii.uib.no>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The information in this message is very interesting, and provided me with
a real insight in the matter of magnetic media.

I was able to read the content, and hopefully understand it correctly,
however, I would not presume to provide an authoritative translation
into English.

I would strongly encourage somebody with fluent Norsk/English skills
to do a translation and post it to the list.

Thank You

Regards Jens Schmidt

Jan-Frode Myklebust wrote:

> On Tue, Feb 12, 2002 at 02:33:47PM +0100, Roy Sigurd Karlsbakk wrote:
> > > IMHO overwriting with /dev/zero or /dev/random is sufficient.
> > > Recovering data after that falls into urban legend category :-)
> >
> > I know of personal experience that the company ibas (http://www.ibas.com)
> > have, in lab, recovered data overwritten >30 times. To recover data
> > overwritten from /dev/zero is done in minutes.
> >
>
> Interessting, but according to the following newsposting (in
> Norwegian) IBAS is clearly stating that they don't know of any
> documented methods to read back overwritten data, or know of anyone
> who are able to do this.
>
>    -jf
>
> -----------------------------------------------------------------------------
> Path: nntp.uib.no!uio.no!nntp.uio.no!not-for-mail
> From: "Erik Andersen" <Erik@Andersen.tf>
> Newsgroups: no.fag.jus.it
> Subject: Re: Loggføring av bevegelser på  Internett
> Date: Thu, 22 Mar 2001 10:17:50 +0100
> Message-ID: <99cg5n$8ur$1@readme.uio.no>
> Reply-To: "Erik Andersen" <Erik@Andersen.tf>
> Xref: nntp.uib.no no.fag.jus.it:387
>
> Med tillatelse fra FoU-sjefen gjengir jeg hans svar i sin helhet:
>
> Jeg skal forsøke å svare på dine spørsmål:
>
> Det korte svaret er: Nei det er ikke mulig å lese data som virkelig fysisk
> er blitt overskrevet.
>
> Imidlertid er grunnen til dette litt annerledes en det du beskriver.  For å
> snakke fornuftig om dette er det først nødvendig med forståelse av hva et
> bit på en HD er. En HD opererer ikke med individuelle bit, men med
> flux-endringer. Flux retning er enkelt fortalt hvorvidt magnet-feltet på
> disken peker mot eller med klokka (CW eller CCW). Så en flux endring er
> altså en endring fra f.eks CW til CCW flux retning. Mapping mellom flux
> endringer er ikke en-til-en. Det betyr at man IKKE benytter CW=0, CCW=1. I
> stedet gir en enkelt.flux-endring opphav til 2.5 til 3 bit. I tillegg
> benytter disken sekvens detektering. Dvs. at den ikke prøver å dekode
> bit'ene hver for seg, men i stedet ser på en hel sekvens (typisk 4096 bit =
> sektor).
>
> Denne sekvensdetekteringen disken gjør ligner mye på hvordan vi leser en
> dårlig telefax. Hvis vi forsøker å lese faxen bokstav for bokstav kan vi
> f.eks lett forveksle en a med en o. Hvis denne bokstaven er en del av ordet
> 'bank', og vi tolker bokstav for bokstav ender vi med ordet 'bonk'.  Hvis vi
> ser på hele ordet (sekvensen med bokstaver) kan vi se at det mest
> sannsynlige ordet er 'bank'.
>
> Det man kan si er at man etter en overskriving kan måle hvor sterke de
> gamle dataene er i forhold til de nye. Det betyr at alle 'gamle' signaler
> faktisk ikke forsvinner. Våre undersøkelser viser imidlertid at det ikke
> finnes noen beskrivelser i litteraturen om hvordan man kan omdanne disse
> signalrestene til de opprinnelige dataene.
>
> Det kan synes som at dette krever banebrytende oppdagelser i en rekke
> disipliner: Ikke-linjær analyse og modellering, lavt-støyende elektronikk
> (cryo-elektronikk), datamaskin teknologi (superraske tallknusere).
>
> Og det var det lange (kompliserte) svaret :)
>
> Det som er sikkert: Ibas kjenner ikke til dokumenterte metoder,
> vitenskapelige miljøer eller kommersielle tjenester som utføre eller
> demonstrere lesing av overskrevne data.
>
> --
> Thor Arne Johansen
> Avdelingssjef FoU, Ibas AS
>
> Han har nå lagt til følgende:
>
> Det er imidlertid på sin plass å nevne at dette er et tema
> hvor de 'lærde' strides. Dvs. det finnes enkelte som mener at det er mulig
> å lese overskrevne data. Men vi har som sagt ikke kunnet finne noe
> vitenskaplig dokumentasjon eller beskrivelser av hvordan dette kan
> gjøres.
>
> -----------------------------------------------------------------------------
>
>   -jf
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

