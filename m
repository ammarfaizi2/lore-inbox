Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTCBBsN>; Sat, 1 Mar 2003 20:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTCBBsN>; Sat, 1 Mar 2003 20:48:13 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:53203 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267263AbTCBBsH>; Sat, 1 Mar 2003 20:48:07 -0500
Message-ID: <3E6167B1.6040206@kegel.com>
Date: Sat, 01 Mar 2003 18:08:49 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Matthias Schniedermeyer <ms@citd.de>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de> 	<3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com>
In-Reply-To: <1046546305.10138.415.camel@spc1.mesatop.com>
Content-Type: multipart/mixed;
 boundary="------------010701040101060107000301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010701040101060107000301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>>I suggest we remove the entries
>>  broken=borken
>>  brain-damaged=dain-bramaged,dain bramaged
>>as we're not trying to remove humor from the comments.
>>
>>Also, the words 'controllen' and 'callin',  are not typos, so
>>  calling=callin
>>should be removed, and
>>  controller=controler,controllen
>>should be just
>>  controller=controler

OK, I've combined my list with the one Matthias posted,
added all the errors that occur in three or more
source files, more or less carefully vetted the list
against the source code, and put together a corrections file
(attached).

I noticed the spellchecker I posted a couple days ago gets confused by
asterisks; for some reason it thinks *foo is the word 'oo'.
I've removed all the mistaken entries in the list caused by this buglet.

This corrections file is probably good enough to actually use.
I'm running it against linux-2.5.63-bk5 now...
- Dan


-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

--------------010701040101060107000301
Content-Type: text/plain;
 name="spell-fix-dan1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spell-fix-dan1.txt"

accessible=accesible
accessing=accesing
accommodate=accomodate,acommodate
Acknowledge=Acknowlege
acknowledged=acknoledged
acquire=aquire
across=accross
actions=actons
adapter=adapater,adaptor,adatper
additional=additionnal
Additional=Addtional
address=adddress,addresss
Address=Adress
Aggressive=Agressive
aggressively=agressively
aligned=alligned
alignment=alignement
already=allready
Always=Allways
always=allways
amount=ammount
appropriate=appropiate,approriate,apropriate
arbitrarily=arbitarily,aribtrarily
Arbitrary=Arbitary
arbitrary=aribtrary
around=arround
assembler=asssembler
associated=assosciated,assosiated
assume=asume
asynchronous=asyncronous
at least=atleast
atomically=atomicly
Auxiliary=Auxilary
available=availble,availible,avaliable
Basically=Basicly
basically=basicly
because=becuase
beginning=beggining
being=beeing
boundaries=boundries
boundary=boundry
cancellation=cancelation
capabilities=capabilites
caught=catched
changeable=changable
character=charater
Characters=Characteres
chose=choosed
chosen=choosen
circumstances=cirumstances
coming=comming
command=comamnd
commence=commense
committed=commited
communication=commuication
comparison=comparision
compatibility=compability
Compatibility=Compatability
compatibility=compatibilty,compatiblity
completely=completly
concurrent=concurent
configuration=configration
consecutive=consequtive
constants=konstants
consumer=comsumer
contiguous=contigious,contingous
Continuous=Continous
continuous=continous
control=controll
controller=contoller,controler
controlling=controling
Converted=Coverted
corresponding=coresponding
courtesy=curteousy
deactivate=deactive
Debugging=Debuging
debugging=debuging
decrementor=decrementer
deferred=defered
definitions=defintions
dependent=dependend
deprecated=depricated
descendant=descendent
descriptor=decriptor,desciptor
developed=developped
didn't=didnt
differentiate=differenciate
discipline=discpline
discontiguous=discontigous
distinguish=distingush
divide=devide
divisor=divizor
Do not=Donot
doesn't=doens't
DOESN'T=DOESNT
doesn't=doesnt
DON'T=DONT
don't=dont't
dynamically=dynamicly
efficient=efficent
empirical=imperical
enhancements=enhandcements
enough=enought
entries=entrys
environment=enviroment
equipped=equiped
error=errror
Evaluate=Evalute
every time=everytime
excess=execess
execution=exection
existence=existance
explicitly=explicitely,explicity
extended=extented
extension=extention
firmware=firware
forward=foward
function=fucntion,fuction,funcion,funciton,functin,funtion
further=furthur
guaranteed=guarenteed
handling=handeling
hardware=harware
hasn't=hasnt
haven't=havn't
I'm=i'm
identical=indentical
immediately=immediatly
implementation=implemantation,implemenation,implmentation
Incoming=Incomming
incoming=incomming
index=indice
indices=indeces
Infinity=Inifity
information=infomation,informatation
initial=inital
initialization=initalization,initilization,intialisation,intialization
Initialize=Initalize
initialize=initalize
Initialize=Initialyze,Initilialyze,Initilize
initialize=initilize,intiailize
Initialize=Intialize
initialize=intialize
instance=isntance
instruction=intruction
interface=inteface
interrupt=interrrupt
Interrupt=Interupt
interrupt=intrrupt
interrupts=interrups
interval=intervall
invariant=invarient
invocation=invokation
isn't=is'nt
issuing=issueing
labeled=labelled
Length=Lenght
License=Licens
Licensed=Licenced
loosely=losely
management=managment,manangement
miscellaneous=miscellaneaous
modeled=modelled
mystery=mistery
necessary=neccessary,necessery
negative=negativ
negotiated=negociated
negotiation=negociation,neogtiation
No-one=Noone
nonexistent=nonexistant
noticeable=noticable
occurrance=occurence
occurred=occured
occurrences=occurances
occurring=occuring
original=orignal
Originally=Originaly
output=ouput
outputting=outputing
overridden=overidden,overriden
parameter=paramter
parameters=paramaters,paramters
particular=paticular
particularly=particularily
Pending=Pendings
Performance=Perfomance
performance=performace,preformance
Peripheral=Periferial
permissible=permissable
physical=hysical,phyiscal
potentially=potentally
preceded=preceeded
preceding=preceeding
presence=presense
privilege=priviledge
promiscuous=promiscous
Propagate=Propogate
prototypes=protoypes
Pseudo=Psuedo
publicly=publically
queuing=queing
really=realy
reasonable=reasonnable,resonable
receive=recevie
Receive=Recieve
receive=recieve
received=recieved
receiving=receving
referred=refered
regardless=regarless
Register=Regsiter,Reigster
registered=registred
registration=registaration
related=releated
relevant=relevent
remaining=remaing
remember=remeber
removable=removeable
renewed=renewd
requests's=requeusts
requests=requeuing
requeue=requests's
requeuing=requeue
reselection=relection
reset=resetted
resources=ressources
responsibility=responsability
retrieve=retreive
safely=savely
safety=saftey
sample=smaple
scatter=scather
scenario=scenerio
Separate=Seperate
Shouldn't=Shouldnt
shouldn't=shouldnt
signaled=signalled
Signaling=Signalling
signaling=signalling
Similarly=Similarily
specific=specfic,specifc
Specification=Specificiation
specified=specifed,speficied
specify=specifiy
specifying=specifing
straightforward=straighforward
structures=stuctures
succeeded=succeded
success=sucess
successful=succesful,successfull
successfully=sucessfully
sufficient=sufficent
superfluous=superflous
suppress=supress
swapped=swaped
synchronize=synchronyze
synchronizing=syncronizing
synchronous=syncronous
threshold=threshhold
through=throught,throuth
timing=timming
TORTUOUS=TORTIOUS
transaction=transation
transceiver=tranceiver
transferred=trasfered
transferring=transfering
translation=tranlation
transmission=transmition,transmittion
transmitter=transmiter
transmitting=transmiting
triggered=tiggered,triggerred
trigging=triggerg
truly=truely
ugliness=uglyness
underrun=underrrun
undesirable=undesireable
Unfortunately=Unfortunatly
unfortunately=unfortunatly
uninitialized=unitialized
unknown=unkown
usable=useable,usuable
useful=usefull
vertices=verticies
warranty=waranty
wasteful=watseful
weird=wierd
writable=writeable
Writing=Writting
writing=writting

--------------010701040101060107000301--

